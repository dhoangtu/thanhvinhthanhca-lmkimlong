% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Dẫn Con Tới Núi Thánh" }
  composer = "Tv. 42"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 b8 |
  b4 c8 c |
  c8. a16 b8 d |
  g,4 c8 b |
  a4 a8 a |
  a8. a16 fs8 e |
  d4 r8 b' |
  c4. c8 |
  b4 a8 a |
  d4 d8 fs, |
  fs4. e8 |
  d4 a'8 fs |
  g2 \bar "||" \break
  
  \set Staff.printKeyCancellation = ##f
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key bf \major
  g8 g ef (d) |
  g4 g8 g |
  a8. bf16 g8 d' |
  d4 r8 ef |
  c4 c8 d |
  bf4. a16 (bf) |
  d,8 d a'16 (bf) a8 |
  g4 r8 <b! g> \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 |
  g4 a8 a |
  a8. fs16 g8 fs |
  e4 e8 g |
  d4 c8 e |
  fs8. e16 d8 c |
  d4 r8 g |
  a4. a8 |
  g4 g8 g |
  fs4 fs8 e |
  d4. c8 |
  b4 c8 d |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Xin thương phái ánh sáng và chân lý Ngài
  dẫn con đi tới núi thánh,
  tới cung điện Ngài,
  Con sẽ tiến tới bàn thờ Chúa,
  đến cùng Ngài hoan lạc của đời con.
  <<
    {
      \set stanza = "1."
      Xin phân xử con,
      biện hộ con chống phường bất nghĩa,
      Chúa ơi xin cứu con khỏi bọn xảo trá gian tà.
      \set stanza = "ĐK."
      Xin
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Sao xua đuổi con, để thù nhân tứ bề áp bức,
	    Chúa ơi xin nhớ con vẫn hằng tìm náu nương Ngài
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Than van làm chi, này hồn ơi chớ thổn thức mãi,
	    vững tin nơi Chúa đi bởi Ngài là Chúa tôi thờ.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
}

TongNhip = {
  \key g \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
    (set! all-grob-descriptions
          (cons ((@@ (lily) completize-grob-entry)
                 (cons grob-name grob-entry))
                all-grob-descriptions)))

#(add-grob-definition
   'StanzaNumberSpanner
   `((direction . ,LEFT)
     (font-series . bold)
     (padding . 1)
     (side-axis . ,X)
     (stencil . ,ly:text-interface::print)
     (X-offset . ,ly:side-position-interface::x-aligned-side)
     (Y-extent . ,grob::always-Y-extent-from-stencil)
     (meta . ((class . Spanner)
              (interfaces . (font-interface
                             side-position-interface
                             stanza-number-interface
                             text-interface))))))

\layout {
   \context {
     \Global
     \grobdescriptions #all-grob-descriptions
   }
   \context {
     \Score
     \remove Stanza_number_align_engraver
     \consists
       #(lambda (context)
          (let ((texts '())
                (syllables '()))
            (make-engraver
             (acknowledgers
              ((stanza-number-interface engraver grob source-engraver)
                 (set! texts (cons grob texts)))
              ((lyric-syllable-interface engraver grob source-engraver)
                 (set! syllables (cons grob syllables))))
             ((stop-translation-timestep engraver)
                (for-each
                 (lambda (text)
                   (for-each
                    (lambda (syllable)
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
                    syllables))
                 texts)
                (set! syllables '())))))
   }
   \context {
     \Lyrics
     \remove Stanza_number_engraver
     \consists
       #(lambda (context)
          (let ((text #f)
                (last-stanza #f))
            (make-engraver
             ((process-music engraver)
                (let ((stanza (ly:context-property context 'stanza #f)))
                  (if (and stanza (not (equal? stanza last-stanza)))
                      (let ((column (ly:context-property context
'currentCommandColumn)))
                        (set! last-stanza stanza)
                        (if text
                            (ly:spanner-set-bound! text RIGHT column))

                        (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                        (ly:grob-set-property! text 'text stanza)
                        (ly:spanner-set-bound! text LEFT column)))))
             ((finalize engraver)
                (if text
                    (let ((column (ly:context-property context
'currentCommandColumn)))
                      (ly:spanner-set-bound! text RIGHT column)))))))
     \override StanzaNumberSpanner.horizon-padding = 10000
   }
}
% kết thúc mã nguồn

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
