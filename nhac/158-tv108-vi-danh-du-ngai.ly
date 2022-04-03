% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vì Danh Dự Ngài" }
  composer = "Tv. 108"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a4 \tuplet 3/2 { bf8 a g } |
  f4. f8 |
  e4 g8 f |
  c4 r8 c16 c |
  c8 g' g f |
  a4. g16 g |
  g8 d' d b! |
  c2 |
  bf4 \tuplet 3/2 { a8 g c } |
  e,4. e8 |
  g g4 f8 |
  c4 r8 c16 c |
  c8 g' g f |
  a4. g16 g |
  g8 bf c e, |
  f2 \bar "||"
  
  e4. f16 d |
  c8 a' a bf |
  g4 r8 f16 f |
  f8 a bf4 ~ |
  bf8 g e16 (g) d'8 |
  c2 |
  bf4 \tuplet 3/2 { d8 bf g } |
  g4. e16 e |
  c8 g' g a |
  a4 r8 g16 g |
  g8 c bf e, |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f4 \tuplet 3/2 { g8 f e } |
  d4. d8 |
  c4 b!8 b |
  c4 r8 c16 c |
  bf8 bf c c |
  f4. f16 f |
  e8 f f d |
  e2 |
  g4 \tuplet 3/2 { f8 e d } |
  c4. c8 |
  b! b4 b8 |
  c4 r8 c16 c |
  c8 b! c c |
  f4. f16 f |
  e8 d c c |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Ôi Chúa con ca ngợi,
  xin đừng nín thinh hoài
  vì bọn người gian ngoa độc dữ
  mở miệng là dối trá đảo điên.
  Chúng vo oan giáng họa
  định quất ngã thân này.
  Dù cùng họ con luôn trìu mến,
  mà họ toàn đem oán đền ơn,
  <<
    {
      \set stanza = "1."
      Họ không chuộng điều trung trinh nghĩa nhân,
      Từng triệt hạ uy hiếp bao kẻ khốn nguy,
      Lời chúng rủa nguyền
      này mong sao lại rơi trên chúng đó,
      nung tim gan, thấu tủy nhập xương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Vì danh dự Ngài xin bênh đỡ con,
	    Vì lòng Ngài nhân ái xin giải thoát con,
	    Con khốn khổ nghèo hèn
	    nghe trong mình tâm can rướm máu,
	    ra đi như bóng ngả chiều rơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bị thiên hạ từng khi khi dể duôi,
	    Nghẹn ngào nhìn lên Chúa con đợi Chúa thương,
	    Mặc chúng rủa nguyền hoài
	    nhưng riêng Ngài xin thương giáng phúc,
	    cho tôi trung Chúa đây mừng vui.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lòng con trọn niềm tri ân Chúa luôn,
	    Từ cộng đoàn dân Chúa con sẽ tán dương,
	    Bởi Chúa thương người nghèo,
	    luôn luôn gần bên ai khốn khó,
	    mau ra tay tế độ chở che.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
  ragged-bottom = ##t
}

TongNhip = {
  \key f \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
