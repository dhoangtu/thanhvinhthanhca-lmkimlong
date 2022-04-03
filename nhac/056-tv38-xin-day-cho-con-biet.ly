% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Dạy Cho Con Biết" }
  composer = "Tv. 38"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c4 |
  g'4. e8 |
  d e4 g8 |
  a4 g8 c ~ |
  c c b e |
  a,4 a8 f ~ |
  f a d, f |
  g4 e16 (g) e (d) |
  c4.
  \afterGrace a'8 ({
    \override Flag.stroke-style = #"grace"
    b16)}
  \revert Flag.stroke-style
  g8 a4 g8 |
  c2 \bar "||" \break
  
  c8. c,16 c (e) f8 ~ |
  f f e f |
  \slashedGrace { a16 ( } g4) c8 c |
  \slashedGrace { a16 ( } g8.) a16 c,8 c16 (d) |
  \slashedGrace { e16 (d } e2) ~ |
  e4 \slashedGrace { d'16 ( } e8) d16 (c) |
  a8. g16 f8 f |
  g g e (d ~ |
  d4) d8 g |
  f8. g16 e8 d |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c4 |
  g'4. e8 |
  d e4 g8 |
  a4 f8 e ~ |
  e a g g |
  f4 f8 d ~ |
  d c a d |
  b4 b8 b |
  c4. f8 |
  e f4 f8 |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Lạy Chúa, xin dạy cho con biết:
  Đời con chung cuộc thế nào,
  tháng ngày đếm được là bao
  Để hiểu rằng:
  Kiếp phù du là thế
  <<
    {
      \set stanza = "1."
      Vẫn tự nhủ tâm: trông chừng đi đứng,
      Giữ lưỡi đừng nói gì lầm lỗi,
      Quyết câm miệng khi còn kẻ dữ đối mặt,
      Chẳng hé môi nói năng một lời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Thấy họ gặp may nghe lòng đau nhói,
	    Tâm can thì bấn loạn sục sôi
	    Tính suy hoài lại càng bừng lên như lửa,
	    Miệng lưỡi tôi nói không nên lời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ấy tuổi đời con đo vài gang tấc,
	    Kiếp sống này Chúa kể bằng không,
	    Sống trên đời con người chỉ như hơi thở,
	    Tựa bóng câu vút qua trên đường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tính chuyện giầu sang,
	    xuôi ngược hôm sớm,
	    Nhắm mắt rồi biết thuộc về ai,
	    Thế nên rầy con còn đợi trông chi nữa,
	    Chỉ biết luôn vững tin nơi Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Cứu giùm mạng con khỏi vòng tội lỗi,
	    Con câm miệng bời Ngài làm thế.
	    Chúa thương tình mau dừng lại bao tai họa,
	    Ngài xuống tay khiến con tơi bời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa trừng trị con như lời cảnh báo,
	    Bao mưu định mối mọt gặm tiêu,
	    Kiếp nhân trần bay vèo tựa như hơi thở,
	    Nguyện Chúa nghe tiếng con kêu cầu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Chúa nhậm lời con van nài tha thiết,
	    Khóc lóc hoài, Chúa đừng làm ngơ,
	    Kiếp lữ hành, thân phận kiều cư trôi nổi,
	    Rồi khuất đi cũng như bao người.
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
  \key c \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #0.7
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
