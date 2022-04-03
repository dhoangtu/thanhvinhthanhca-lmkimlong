% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Nhậm Lời Và Xót Thương" }
  composer = "Tv. 29"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 g8 e |
  d d b'16 (c) b8 |
  a4. g8 |
  c8. b16 a8 a |
  d2 ~ |
  d4 d8 bf |
  bf4. c8 |
  c a4 bf8 |
  g4 d8 bf' |
  a8. g16 d'8 d ~ |
  d e c d |
  b4 r8 b |
  b4 c8 a |
  b g a16 (g) e8 |
  e4. e8 |
  d d fs g |
  a4. g8 |
  c4 a8 d |
  g,2 \bar "||"
  
  g8 g g16 (a) g8 |
  e4. c8 |
  c8. g'16 g8 e |
  d2 ~ |
  d8 g fs16 (g) fs8 |
  e8. c'16 c8 b |
  a2 |
  fs8. a16 g8 e |
  d4 r8 g |
  a8. g16 a8 g |
  fs2 ~ |
  fs8 e e e16 (g) |
  a8. c16 b8 a |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 e |
  d d g16 (a) g8 |
  fs4. f!8 |
  e8. g16 g8 g |
  fs2 ~ |
  fs4 fs8 g |
  g4. g8 |
  ef d4 c8 |
  bf4 bf8 g' |
  d8. d16 b'!?8 b ~ |
  b c a g |
  g4 r8 g |
  g4 a8 fs |
  g e d [d] |
  c4. c8 |
  b b d e |
  fs4. e8 |
  a (g) fs fs |
  g2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Xin nhậm lời và xót thương con,
  lạy Chúa, xin Ngài trợ giúp.
  Khúc ai ca Chúa biến thành vũ điệu,
  Cởi áo xô, mặc cho con lễ phục huy hoàng,
  Nên con sẽ không ngớt lời ca tụng Ngài,
  muôn đời hằng tạ ơn mãi,
  lạy Chúa con kính thờ.
  <<
    {
      \set stanza = "1."
      Con xin tán ương Ngài,
      vì Ngài cất nhắc con lên,
      không để quân thù đắc chí trên con.
      Lạy Chúa con tôn thờ,
      con đã kêu cứu lên Ngài
      và ngài dủ thương chưa con an lành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ca khen thánh danh Ngài,
	    nào mọi tín hữu nơi nơi,
	    cơn giận của Ngài phút chốc phôi pha
	    mà mến thương muôn đời,
	    ban tối cho có rơi lệ,
	    vầng hồng vừa lên sướng vui reo hò.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Khi con sống yên hàn nhủ lòng mãi mãi không nao,
	    thanh thản luôn vì Chúa mến thương con
	    đặt giữa nơi an toàn,
	    nhưng mới khi Chúa ẩn mặt
	    là lòng dạ con xốn xang rợn rùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bao nhiêu nắm tro tàn
	    nào còn hát kính Tôn Danh,
	    Khi đẩy con vào cõi chết thẳm sâu
	    thì Chúa đâu lợi gì?
	    Xin đoái nghe tiếng con cầu,
	    một niềm cậy trông Đấng con tôn thờ.
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
  page-count = #1
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
     (padding . 0.5)
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
    \override Lyrics.LyricSpace.minimum-distance = #0.4
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
